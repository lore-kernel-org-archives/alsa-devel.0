From: jhall@UU.NET (Jeremy Hall)
Subject: when did the rme9652 driver break?
Date: Tue, 19 Feb 2002 10:03:42 -0500 (EST)
Message-ID: <QQmcwy07240.200202191503@neserve0.corp.us.uu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

What is going on? my computer goes on vacation for a week and when it
returns and updates its CVS, alsa now locks the kernel when I try to use
the rme9652 card.  Jack whines about loads of xruns, which get larger as
time goes by, resulting in a system crash that must be hard-reset.

When were these unstable changes introduced so I may revert back to a more
stable build?

Other apps besides jack can cause the computer to lock as well.

_J

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
