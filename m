From: "Thomas De Schampheleire" <patrickdepinguin@gmail.com>
Subject: Mic Boost on Realtek ALC883 (alsa-driver bug 2668)
Date: Sat, 20 Jan 2007 19:55:05 +0100
Message-ID: <9d133f60701201055r786a4217q19de97c01c9644f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1169022534=="
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

--===============1169022534==
Content-Type: multipart/alternative;
	boundary="----=_Part_31871_31733190.1169319305894"

------=_Part_31871_31733190.1169319305894
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

The Alsa driver does not offer a Mic Boost on Realtek ALC883 chips, even
though the chip itself supports it. I have filed a bug for this some time
ago, along with a patch, but never received any reply to this by any Alsa
developer.

The patch is very simple and straightforward, similar to the mic boost on
the other realtek chips.

Please consider this patch for inclusion in the next Alsa release, or let me
know why I do not receive any feedback.

See here: https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2668

Thank you,
Thomas De Schampheleire

------=_Part_31871_31733190.1169319305894
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, <br><br>The Alsa driver does not offer a Mic Boost on Realtek ALC883 chips, even though the chip itself supports it. I have filed a bug for this some time ago, along with a patch, but never received any reply to this by any Alsa developer. 
<br><br>The patch is very simple and straightforward, similar to the mic boost on the other realtek chips.<br><br>Please consider this patch for inclusion in the next Alsa release, or let me know why I do not receive any feedback.
<br><br>See here: <a href="https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2668">https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2668</a><br><br>Thank you, <br>Thomas De Schampheleire<br>

------=_Part_31871_31733190.1169319305894--


--===============1169022534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1169022534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1169022534==--
