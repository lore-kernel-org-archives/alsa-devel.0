From: "Clemens Ladisch" <clemens@ladisch.de>
Subject: Re: [alsa-cvslog] alsa-kernel: fm801: move
 CONFIG_VIDEO_DEV dependency to CONFIG_SND_FM801_TEA575X_BOOL
Date: Fri, 18 Aug 2006 10:56:22 +0200
Message-ID: <1155891382.17094.268669006@webmail.messagingengine.com>
References: <ALOGGER1155885865.57@alsa-project.org>
	<s5hveoqzcz6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hveoqzcz6.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Clemens Ladisch wrote:
> > files:       pci/Kconfig
> > description:
> > fm801: move CONFIG_VIDEO_DEV dependency to CONFIG_SND_FM801_TEA575X_BOOL
> > 
> > Move the CONFIG_VIDEO_DEV dependency from CONFIG_SND_FM801_TEA575X to
> > CONFIG_SND_FM801_TEA575X_BOOL so that the two symbol always have
> > consistent values even when compiled externally.
> 
> Is it a really correct fix?
> It looks like that this forces CONFIG_VIDEO_DEV=y even though it's not
> necessarily so.

Uh, yes.

I guess a better fix would be to change the code to not look at
CONFIG_SND_FM801_TEA575X_BOOL at all.

> The problem in alsa-driver's build is that SND_FM801_TEA575X_BOOL is
> evaluated after SND_FM801 and SND_FM801_TEA575X because the former is
> an option.  In acinclude.m4, the whole checks of options are done
> after cards.
> 
> Maybe a better way would be to change acinclude.m4 like:
> 
> 	CARDS="xxx yyy ..."
> 	OPTIONS="aaa bbb ..."
> 
> 	ac_snd_config_exists () {
> 		# check whether $1 is in cards or options
> 	}
> 
> 	# then check each card/option in the order appearing in
> 	# Kconfig
> 	if ac_snd_config_exists ad1816a; then
> 		....
> 	fi
> 	if ac_snd_config_exists ad1816a; then
> 		....
> 	fi

I'm not sure it would be a good idea to rewrite all this just before
the .12 release.


I'll revert this one and do the change I proposed above over the weekend
unless anybody objects.


Regards,
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
