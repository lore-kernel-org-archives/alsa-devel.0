From: "Fabien COMTE" <fabien.comte@ercogener.com>
Subject: Application and hw mixing for VoIP (modified)
Date: Mon, 21 Sep 2009 15:48:39 +0200
Message-ID: <15122.560671489$1253540932@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-msa-out01.orange.fr (smtp-msa-out01.orange.fr
	[193.252.23.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A4E8103814
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Sep 2009 15:48:41 +0200 (CEST)
Content-Language: fr
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
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
