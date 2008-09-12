From: William Estrada <MrUmunhum@popdial.com>
Subject: alsa callback not async
Date: Fri, 12 Sep 2008 13:21:04 -0700
Message-ID: <48CACF30.90707@popdial.com>
Reply-To: MrUmunhum@popdial.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: "alsa-user@lists.sourceforge.net" <alsa-user@lists.sourceforge.net>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi guys,

  I am cross posting this because I am not sure which list it belongs to.

  I have a test program I wrote to help me learn ALSA APIs, It work to a 
degree. It is a
simple Capture/Playback interface. My problem is that when the Callback 
starts, it
does not allow any cycles back to the main program. The main program 
waits for console
input to tell the callback when to stop. Well it does not accept any 
console input when
the callback is running. Any ideas??

  The source is here: http://64.124.13.3/_ALSA_/Echo/

-- 
William Estrada
MrUmunhum@popdial.com
Mt-Umunhum-Wireless.net ( http://Mt-Umunhum-Wireless.net )
Ymessenger: MrUmunhum



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
