From: Frank Neumann <beachnase@web.de>
Subject: Re: Rawmidi mystery
Date: Wed, 5 Feb 2003 20:48:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18gVVU-0007zl-00@smtp.web.de>
References: <E18gCZI-0002XD-00@smtp.web.de>
	<s5hsmv2g3kv.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Wed__5_Feb_2003_20:48:02_+0100_08386130"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hsmv2g3kv.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.

--Multipart_Wed__5_Feb_2003_20:48:02_+0100_08386130
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi list,
Takashi Iwai <tiwai@suse.de> wrote:

[..]

> > Normally, according to the M3r's SysEx implementation in its manual,
> > this should give the same output, exactly 23963 bytes.
> > However, the second version loses about 130 bytes during the transfer.
> > The strange thing is that the beginning of the data (SysEx header:
> > F0 42 30 24...) is fine, and starting around byte 700 the data is exactly
> > the same as in the correct output, including the EOX (F7) at the very end of
> > the output. But somewhere in this first part, data is lost.
>  
> just to be sure:  any realtime events can come in?

No, I checked that. The M3r sends active sensing (0xfe), but I filtered that out.
In the data I get the only MIDI bytes > 0x7f are the F0 at the start and the
0xF7 at the very end. Also, I think a SysEx message cannot be interrupted by
any other message, right?

> > This number was observed to be in a range of +-20 bytes.
> > Could anyone explain this? Though the MIDI interface on the PC side
> > is in a cheapo Soundblaster PCI512 card, I don't think it's responsible
> > for data losses. To me this looks rather like a rawmidi problem. The
> > program really doesn't do much more but snd_rawmidi_open, snd_rawmidi_write,
> > snd_rawmidi_read, snd_rawmidi_drain and snd_rawmidi_close.
> 
> as Clemens wrote, please check the buffer overruns.
> the buffer overruns are shown in /proc/asound/card0/midiX proc file
> but only during the midi is opened for read.

I checked that - no overruns during the whole transfer. At the end of
the transfer (but before the device is closed) I see:
franky@faramir:/proc/asound/card0> cat midi0
EMU10K1 MPU-401 (UART)

Output 0
  Tx bytes     : 7
  Mode         : native
  Buffer size  : 4096
  Avail        : 4096
Input 0
  Rx bytes     : 23860
  Buffer size  : 4096
  Avail        : 24
  Overruns     : 0

The 24 avail input bytes are ActiveSensing bytes.

I have attached the small program to this mail for your studying
pleasure :-}. If anything is wrong, I'd certainly love to hear about
that. This is the first ALSA rawmidi program I've written.

I'll dive into the M3r's SysEx docs and the dump I get once more; maybe
there is something I overlooked.

Thanks,
Frank

--Multipart_Wed__5_Feb_2003_20:48:02_+0100_08386130
Content-Type: text/x-csrc;
 name="m3r2.c"
Content-Disposition: attachment;
 filename="m3r2.c"
Content-Transfer-Encoding: 7bit


/*
 * m3rx: Small ALSA-based (using rawmidi API) program to get a complete bulk dump from
 * a Korg M3r expander module. No checksums, no flow control, nothing yet.
 *
 * Copyright (c)2003 Frank Neumann
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <alsa/asoundlib.h>

#define ST_START		0x00
#define ST_IN_SYSEX	0x01
#define ST_DONE		0x02

/*** START OF MAIN FUNCTION ***/
int main(int argc, char* argv[])
{
	int err, state, numbytes;
	unsigned char ch;
	unsigned char sysex_get_all[] = { 0xf0, 0x42, 0x30, 0x24, 0x0f, 0x00, 0xf7 };

	FILE *fp1;
	snd_rawmidi_t *raw_in = 0, *raw_out = 0;

	if (argc != 2)
	{
		fprintf(stderr, "Usage: %s <outputsysexfilename>\n", argv[0]);
		exit(5);
	}

	fp1 = fopen(argv[1], "w");
	if (fp1 == NULL)
	{
		fprintf(stderr, "Unable to open output file '%s'\n", argv[1]);
		exit(5);
	}
			
	err = snd_rawmidi_open(&raw_in, NULL, "default", 0);	
	if (err)
	{
		fprintf(stderr,"snd_rawmidi_open 'default' failed: %d\n", err);
		exit(5);
	}

	err = snd_rawmidi_open(NULL, &raw_out, "default", 0);	
	if (err)
	{
		fprintf(stderr,"snd_rawmidi_open(2) 'default' failed: %d\n", err);
		exit(5);
	}

	fprintf(stderr, "rawmidi device opened sucessfully.\n");
	fprintf(stderr, " Now sending ALL DATA DUMP REQUEST...\n");
	snd_rawmidi_write(raw_out, &sysex_get_all, sizeof(sysex_get_all));
	snd_rawmidi_drain(raw_out); 

	fprintf(stderr, "[Waiting for SysEx sequence to start]\n");
	
	state = ST_START;
	numbytes = 0;
	while (state != ST_DONE)
	{
		snd_rawmidi_read(raw_in,&ch,1);
		switch(state)
		{
			case ST_START:
					if (ch == 0xf0)
					{
						fprintf(stderr, "[SysEx start code found, writing data]...\n");
						state = ST_IN_SYSEX;
						fputc(ch, fp1);
						numbytes++;
//						fprintf(stderr, "\r%06d bytes written...   ", numbytes);
					}
					break;
			case ST_IN_SYSEX:
					if (ch < 0x80)
					{
						fputc(ch, fp1);
						numbytes++;
//						fprintf(stderr, "\r%06d bytes written...   ", numbytes);
					}
					else if (ch == 0xf7) /* EOX */
					{
						fputc(ch, fp1);
						numbytes++;
//						fprintf(stderr, "\r%06d bytes written...   ", numbytes);
						fprintf(stderr, "\n[SysEx EOX code found, finishing - %d bytes written]\n", 
								numbytes);
						state = ST_DONE;
					}
					break;

			default:
				break;
		}
	}

	snd_rawmidi_drain(raw_in); 
	snd_rawmidi_close(raw_in);	
	snd_rawmidi_close(raw_out);	
	fclose(fp1);
}


--Multipart_Wed__5_Feb_2003_20:48:02_+0100_08386130--


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
