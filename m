From: Anders Torger <torger@ludd.luth.se>
Subject: Re: RME Hammerfall HDSP 9652: no configurations available
Date: Sat, 19 Jul 2003 19:32:55 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307191932.55083.torger@ludd.luth.se>
References: <E19dv4a-0001hF-00@sc8-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E19dv4a-0001hF-00@sc8-sf-list1.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>, Thomas Charbonnel <thomas@undata.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Saturday 19 July 2003 19.06, Paul Davis wrote:
> >> I'm trying out the HDSP driver from CVS (checked out today), on a
> >> RME HDSP 9652 PCI card, but I don't manage to get it to run, with
> >> my basic test
> >>
> >> # aplay -D hw -f S32_LE -c 26 -r 48000 /dev/zero
> >>
> >> Playing raw data '/dev/zero' : Signed 32 bit Little Endian, Rate
> >> 48000 Hz, Channels 26
> >> aplay: set_params:787: Broken configuration for this PCM: no
> >> configurations available
> >>
> >> The firmware is loaded using hdsploader. Running aplay on another
> >> sound card on the machine works.
> >
> >Note you don't need to run hdsploader with hdsp9652 cards.
>
> why don't you just try it with plughw rather than hw. i'm not sure
> that what aplay tries to do with the configuration you've attempted
> to provide is actually correct.

The problem was that the CVS was not properly updated yet with all 
patches (due to the 24 hour delay, which I did not know about :-\ ). 
Now it works, oh well, not with that configuration above, one has to 
tell aplay to run in non-interleaved mode, which unfortunately only can 
be done indirectly, by specifying separate files for each channel, so 
my basic test became:

aplay -D hw -I -f S32_LE -c 26 -r 48000 \
/dev/zero /dev/zero /dev/zero /dev/zero /dev/zero /dev/zero /dev/zero \
/dev/zero /dev/zero /dev/zero /dev/zero /dev/zero /dev/zero /dev/zero \
/dev/zero /dev/zero /dev/zero /dev/zero /dev/zero /dev/zero /dev/zero \
/dev/zero /dev/zero /dev/zero /dev/zero /dev/zero 

which worked. I discovered an issue with AutoSync though, which is 
delivered in a separate mail.

I'm using hw directly by tradition I guess...

/Anders Torger



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
