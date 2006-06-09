From: Lee Revell <rlrevell@joe-job.com>
Subject: Device enumeration
Date: Fri, 09 Jun 2006 02:36:49 -0400
Message-ID: <1149835010.3894.171.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

In order for apps to support ALSA properly there NEEDS to be a proper
device enumeration API!  I was just looking at the OpenWengo site:

http://www.openwengo.org/index.php/openwengo/public/homePage/news?payload[newsId]=0

and it seems that their ALSA device selector only lists hw devices.  IOW
it's no improvement over OSS.

Will this be fixed soon?  I cannot see how we can ever expect apps to
support ALSA properly without it.  There's currently a perception that
apps must be modified to "support dmix" when all that is really needed
is to have a device enumeration that will list the default device.

It cannot be a coincidence that 99% of the apps that try to support ALSA
get it wrong.

Lee
