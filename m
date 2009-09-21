From: "Fabien COMTE" <fabien.comte@ercogener.com>
Subject: Application and hw mixing for VoIP (modified)
Date: Mon, 21 Sep 2009 15:48:39 +0200
Message-ID: <18869.4094111726$1253542904@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-bounces@lists.sourceforge.net>
Content-Language: fr
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
I need some help please.
I have an application that does VoIP and alsa interface.

I want to :
- send through VoIP application a mixed sound from mic and an another
application (aplay should be ok for testing).

mic ---------- soundcard 0 ------------->
                                           mix  ---- alsa interface ----->
voip application
application 1 --- alsa interface  ------>
(aplay)

- use sound received from VoIP with HP output and an another application
(arecord should be ok for testing).

                                                   ----- alsa interface
------> application 2 (arecord)
voip application ----- alsa interface ---->  share
                                                   ------ soundcard 0
--------> HP output


And a little question :
How to define an application interface in asoundrc ?
	

I tried a lot of asoundrc but they doesn't work.

Could someone help me ?
Thank you.

Fabien




------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
