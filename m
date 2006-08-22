From: "Clemens Ladisch" <clemens@ladisch.de>
Subject: Re: [alsa-cvslog] alsa-kernel: fm801: move
 CONFIG_VIDEO_DEV dependency to CONFIG_SND_FM801_TEA575X_BOOL
Date: Tue, 22 Aug 2006 09:31:42 +0200
Message-ID: <1156231902.24818.269111555@webmail.messagingengine.com>
References: <ALOGGER1155885865.57@alsa-project.org>
	<s5hveoqzcz6.wl%tiwai@suse.de>
	<1155891382.17094.268669006@webmail.messagingengine.com>
	<s5hr6zez9xb.wl%tiwai@suse.de>
	<1155893106.18755.268671127@webmail.messagingengine.com>
	<s5hoduiz8j3.wl%tiwai@suse.de>
	<1155911750.14091.268690972@webmail.messagingengine.com>
	<s5h4pwa14xu.wl%tiwai@suse.de>
	<1156146725.19545.269017711@webmail.messagingengine.com>
	<s5h4pw6s1zr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h4pw6s1zr.wl%tiwai@suse.de>
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
> I think it's a bug that config1.h is written before any manual
> modifications like configs for OSS emulation.  We should move writes
> to config1.h to a later stage as you suggested.

Done, but only for the TEA575x workaround.  I didn't test what the
consequences of the OSS change would be.


Regards,
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
