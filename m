From: "littertiger" <tiger_zsch@163.com>
Subject: snd_pcm_lib_preallocate_pages_for_all in armlinux
Date: Fri, 13 Oct 2006 12:47:32 +0800
Message-ID: <45189.2672609121$1160714734@news.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1572818860=="
Return-path: <alsa-user-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>, "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--===============1572818860==
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit

Hi,all

In armlinux, there's no isa,pci...  
What should I set type and data to in the following function:
int snd_pcm_lib_preallocate_pages_for_all(snd_pcm_t *pcm,
					  int type, void *data,
					  size_t size, size_t max)

BEST RIGARDS
littertiger 				




--===============1572818860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1572818860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user

--===============1572818860==--
