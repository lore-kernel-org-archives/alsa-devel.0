From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: Re: Tascam US-224 progress report (was:     
     USB224_usbsnoop1.log captured  on WinXP)
Date: Tue, 6 Apr 2004 01:10:15 +0100 (WEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <32796.192.168.1.5.1081210215.squirrel@www.rncbc.org>
References: <200404021434.26528.annabellesgarden@yahoo.de>  
    <32789.192.168.1.5.1080955456.squirrel@www.rncbc.org>  
    <200404060008.55634.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20040406011015_46597"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200404060008.55634.annabellesgarden@yahoo.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

------=_20040406011015_46597
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

Karsten Wiese wrote:

> Am Samstag 03 April 2004 03:24 schrieb Rui Nuno Capela:
>> I have news, and they're good this time.
>> After some juggling and persistance around compiling and patching
>> the snd-usb-usx2y module, I've finally got that dreaded INPUT
>> MONITOR LED come to light and, as Karsten rightly prehome/rncbc/dicted,
>> playback has shown its ugly head on my Tascam US-224. Hip, hip, hurray!
>>
>> Like a miracle, the MUTE and SELECT LED lights of the mixer strips 1-4
>> are lightning up too. Again, Karsten tips are quite cirurgical :)
>> However, I don't get the SOLO, REC, NULL, nor all other transport LEDs
>> to lit. But that's yet another step, I think the next.
>
> Ok, go for it. Should be fairly easy. Just implement the sink-side of
> the alsa-sequencer interface in us428control ;-)
> erm.... no it is not implemented yet.
> The Transport Lights could react to MMC Messages.
> MUTE, REC, SOLO & SELECT Lights would be controlled by i. e. ardour.
>

Oh yeah? That's great, but I'm afraid my ardour is still with it's default
configuration (trident anyone?). Does anybody have a quick and dirty
"solution" on how to change this? Please forgive my idleness :)

>
> NULL-Mode is a little more complicated:
> In INPUT MONITOR Mode us428control knows all to handle it.
> In not INPUT MONITOR Mode us428control has to know from i. e. Ardour
> the Mixer Settings to compare them with the actual state.
>

I don't even have a clear idea on whether this NULL-mode is all about, so
let's leave it for a little bit later, OK? :)

>
> Please make shure it also works without debug mode. after make clean.
>

Now comes the weird part. No, I couldn't get it to work unless I set
--with-debug=full on configure line. And I've tested several times,
believe me.

FYI, I'm stick with 2.6 kernel tree, and already tested with 2.6.4 and
latest 2.6.5.

My way of building the kernel modules is from stock tarball, and is pretty
canonical, as literally as follows (all as root):

  tar -jxf alsa-driver-1.0.4.tar.bz2
  cd alsa-driver-1.0.4
  gzip -dc ../alsa-driver-1.0.4p1.patch.gz	# see attachment
  ./configure --with-isapnp=no --with-sequencer=yes --with-oss=yes
--with-cards=all --with-debug=full
  make
  make install

As stated, the INPUT MONITOR LED does not get lit if I take out the clause
--with-debug=full.

How come?
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


------=_20040406011015_46597
Content-Type: application/x-gzip; name="alsa-driver-1.0.4p1.patch.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="alsa-driver-1.0.4p1.patch.gz"

H4sICDI+cEAAA2Fsc2EtZHJpdmVyLTEuMC40cDEucGF0Y2gAlVFbSyMxFH7u/Irji3ScZprEmbZW
WsqyKqJIUQR9Cukk1YCdDLmUXfXHm8yMsAu7D/1IyHn4LuecCLXdAhJ+fWeAv1mOhFF7aRDJcV40
eOztJtxf9Hes2oJ7oXRe/YNN/s9OEEKH+Q8oxgXCp+gUAz6b0+mcTHL8DcgwwTjJsuywPnrXeIBM
52U5J9N8VmKKy1k56V1XK0CEFuVoCln/rlYJDCBgEBELsLVgYsdZpWunaq+9ZYI7Pry6XLObi/u7
i9t0lHT8TuDtE31mFW8cs35jnZF8h5ayFo1WtbNwApPihGBaHCojdNbq0hQ+PxPUyoatbFhxI1K0
rF5Vkwu5R0shbWVU47TJlVgbLXzlYLGAx4cf7Pone3wo6AyOj5PscJejP1wIpdGl2xlgWMJQGgOL
fhrDnWRWus6fdUONoCjC+tMA+BiMx3Arw3jexo6MrPRLrd4laO8a79Bev/mdhOARlv9iRyCUdd5s
oiCE53GF8Ye6gPb3+xi2NVL+FZyeR7aRQV9DaPM8+QIVmsH8FgMAAA==
------=_20040406011015_46597--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
