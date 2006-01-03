From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Simple question.
Date: Tue, 03 Jan 2006 22:24:12 +0000
Message-ID: <43BAF98C.6030408@superbug.co.uk>
References: <8c38cea40601031342s7b3158e2k99de34c50c4fb6ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <8c38cea40601031342s7b3158e2k99de34c50c4fb6ff@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: LWATCDR <lwatcdr@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

LWATCDR wrote:
> I am just starting to work with Alsa I compiled a test program from one of
> the tutorials and I am getting this error message.
> Unknown Error 126.
> Does anyone know what error 126 is?
> I am using "plughw:0,0" as the device name.
> and this is the segment of code that generates the error.
> 
> for (i = 0; i < 10; ++i) {
> if ((err = snd_pcm_writei (playback_handle, buf, 128)) != 128) {
>     fprintf (stderr, "write to audio interface failed (%s)\n", snd_strerror
> (err));
>     exit (1);
>     }
> }
> 
> 
> I am running Suse 9.3+kde 3.5
> 
> I hope this is the correct list to ask this.
> 

If the err > 0, it tells you how many frames were written to the sound 
card. As you can see here, 126 frames were written, probably due to 
sound card's hardware buffer being full.

James



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
