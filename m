From: "Peter Zubaj" <pzad@pobox.sk>
Subject: Re: Re: RFC: OSS driver removal, a slightly different
Date: Fri, 20 Jan 2006 15:46:30 +0100
Message-ID: <4135590e93824f9b8c282cf796d8469e@pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: alsa-devel@lists.sourceforge.net, Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

This is same problem as with emu10k1

4 chanels are splited to front and rear alsa devices and there is virtu=
al 4 channel device implemented using alsa-libs plugins in user space=2E
Alsa applications uses this virtual device when plaing 4 channel sound=2E=
 Alsa-oss kernel emulation doesn't know about this and uses alsa hw dev=
ices directly, but only as separated devices (front and rear)=2E

You can try to use aoss (I not tested this)=2E

Peter Zubaj

>>Hi,
>>
>>On Thursday 19 January 2006 18:46, Adrian Bunk wrote:
>>> SOUND_EMU10K1
>>> - ALSA #1735 (OSS emulation 4-channel mode rear channels not workin=
g)
>>
>>If I understand alsa - oss emulation correctly, I think, this will be=
 not
>>fixed soon (my opinion - never)=2E This is too much work for too litt=
le gain=2E
>
>On that way, I'd like to inquiry something:
>I have a card that works with the snd-cs46xx module=2E
>With the OSS emulation (/dev/dsp), I can only output 2 channels, and t=
he
>other two must be sent to /dev/adsp=2E Is this intended? Would not it =
be
>easier to make /dev/dsp allow receiving an ioctl setting 4 channels?
>



Aktivujte si neobmedzenu mailovu schranku na www.pobox.sk!




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
