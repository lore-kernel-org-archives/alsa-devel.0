From: Lee Revell <rlrevell@joe-job.com>
Subject: possible ens1371 bug
Date: Mon, 06 Sep 2004 18:06:16 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1094508375.29921.83.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Yesterday, when unmuting the 'AD Input Select' in alsamixer, the system
locked up hard.  I have been unable to reproduce the problem but figured
someone who knew the code might find a bug.  AFAIK this device doesn't
have any digital inputs so maybe the control is unnecessary.

 Card: Ensoniq AudioPCI                                                       
 Chip: Asahi Kasei AK4531                                                     
 Item: AD Input Select

System is Debian unstable, kernel 2.6.8 and alsa 1.0.5 from the debian
packages.

HTH,

Lee



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
