From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-user] audigy NX 2 alsa and fedora C1
Date: Thu, 26 Aug 2004 16:28:40 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1093552120.5678.88.camel@krustophenia.net>
References: <Pine.HPX.4.33n.0408261727420.9298-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0408261727420.9298-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: =?ISO-8859-1?Q?Fran=E7ois?= Patte <Francois.Patte@math-info.univ-paris5.fr>, alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 2004-08-26 at 11:29, Clemens Ladisch wrote:
> François Patte wrote:
> > I can "see" my sound card with lsusb:
> >
> > Bus 002 Device 002: ID 041e:3020 Creative Technology, Ltd
> >
> > But  cat /proc/asound/cards replies:
> >
> > --- no soundcards ---
> >
> > lsmod | grep snd gives:
> >
> > snd-usb-audio          60192   0  (unused)
> > ...
> > and the audio modules is also installed.
> 
> The audio module is the kernel's oss driver which conflicts with the
> ALSA driver.  Don't load it.
> 

This seems to be the second most common source of problems (#1 being
mixer issues): conflicts between ALSA and OSS drivers.

Would it be feasible to have the ALSA drivers detect if there is an OSS
module loaded, and complain loudly?  Then at least it will show up in
dmesg.

Lee



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
