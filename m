From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-user] Play two sounds at once
Date: Sat, 17 Dec 2005 14:17:32 -0500
Message-ID: <1134847052.11227.17.camel@mindpipe>
References: <15c45fbc0512160524n4adb7d4bw16617ac7a61ad4b4@mail.gmail.com>
	 <200512161526.33366.ismail@uludag.org.tr>
	 <15c45fbc0512160533y40ace2a4g4c9daddb5e7fafbd@mail.gmail.com>
	 <200512161541.50627.ismail@uludag.org.tr>
	 <1134758785.17808.5.camel@mindpipe>  <20051217174854.GG31746@localhost>
	 <1134844578.11227.6.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1134844578.11227.6.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Wulf Assols <wulf.assols@arcor.de>
Cc: alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Sat, 2005-12-17 at 13:36 -0500, Lee Revell wrote:
> On Sat, 2005-12-17 at 18:48 +0100, Wulf Assols wrote:
> > Hi Lee!
> > 
> > On Fri, 16 Dec 2005, Lee Revell wrote:
> > 
> > > On Fri, 2005-12-16 at 15:41 +0200, Ismail Donmez wrote:
> > > > Cuma 16 Aral?k 2005 15:33 tarihinde, Darrell Blake ?unlar? yazm??t?: 
> > > > > > Use a recent version of ALSA which setups dmix automagically, so you can
> > > > >
> > > > > play
> > > > >
> > > > > > do this without configuring anything.
> > > > >
> > > > > I think I'm already using the latest version of ALSA. I'm running the
> > > > > 2.6.14.3 kernel and whichever version of ALSA comes with it.
> > > > 
> > > > Then your soundcard might not be able to do dmix at all. Worth a check 
> > > > alsa-wiki.
> > > 
> > > Any soundcard can do dmix, as the point of dmix is to do mixing in
> > > software for devices that can't do it themselves.  Some are just more
> > > work to get the .config right, like usb-audio and ICE1724, so it does
> > > not work OOTB yet.
> > > 
> > > Lee
> > what do you have to do to make dmix work with the ICE17xx chip? (i got an
> > ICE1712)
> 
> Make sure you have alsa-lib 1.0.10 or newer installed and remove
> your .asoundrc and it should work.  I don't have one of these devices
> but IIRC people have reported it should work.  Maybe someone who has
> this working with ALSA 1.0.10 or newer can help more?

Never mind, it looks like ICE1712.conf does not configure dmix
automatically after all.

Try this patch.

Lee

ICE1712: Use dmix/dsnoop by default

Signed-Off-By: Lee Revell <rlrevell@joe-job.com>

Index: alsa-lib/src/conf/cards/ICE1712.conf
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/conf/cards/ICE1712.conf,v
retrieving revision 1.8
diff -u -r1.8 ICE1712.conf
--- alsa-lib/src/conf/cards/ICE1712.conf	27 Jan 2004 09:47:13 -0000	1.8
+++ alsa-lib/src/conf/cards/ICE1712.conf	17 Dec 2005 19:13:03 -0000
@@ -2,6 +2,29 @@
 # Configuration for the ICE1712 (Envy24) chip
 #
 
+# default with dmix & dsnoop
+ICE1712.pcm.default {
+	@args [ CARD ]
+	@args.CARD {
+		type string
+	}
+	type asym
+	playback.pcm {
+		type plug
+		slave.pcm {
+			@func concat
+			strings [ "dmix:" $CARD ",FORMAT=S32_LE" ]
+		}
+	}
+	capture.pcm {
+		type plug
+		slave.pcm {
+			@func concat
+			strings [ "dsnoop:" $CARD ",FORMAT=S32_LE" ]
+		}
+	}
+}
+
 <confdir:pcm/front.conf>
 
 ICE1712.pcm.front.0 {




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
