From: "Adrian McMenamin" <adrian@mcmen.demon.co.uk>
Subject: Re: DMA strangeness?
Date: Tue, 21 Feb 2006 15:43:15 -0000 (GMT)
Message-ID: <49492.217.150.108.178.1140536595.squirrel@newgolddream.dyndns.info>
References: <1140361953.9117.9.camel@localhost.localdomain>
    <s5hlkw4ka19.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hlkw4ka19.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 21 February, 2006 3:26 pm, Takashi Iwai wrote:
> At Sun, 19 Feb 2006 15:12:33 +0000,
> Adrian McMenamin wrote:
>>
>> I am using oss emulation to test my driver (I cannot get the alsa
>> utilities to work properly on my Dreamcast (SH4/uclibc) system).
>>
>> When I do something like
>>
>> cat foobar > /dev/dsp
>>
>> it seems that the DMA buffer is filled with doubles of every byte of
>> foobar eg if foobar was 0xFF, 0x10 ... etc then the first four bytes o=
f
>> the DMA buffer would be 0xFF 0xFF 0x10 0x10
>>
>> Is there a reason for this? Obviously I've made a mistake somewhere bu=
t
>> I don't know where
>
> Depending on the configuration, the mono signal is expanded to
> stereo.
>

Thanks. I guessed it was probably some sort of stereo sep stuff. How do I
control this - where are the sources I can look at?

The way my card works that might not be the best way of doing it - I need
to load the left and right channels into two different buffers in the
device space - or else find a very different way to arrange the playback.



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log fi=
les
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D103432&bid=3D230486&dat=3D=
121642
