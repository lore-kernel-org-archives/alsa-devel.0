From: Singaravelan Nallasellan <singaravelann@hotmail.com>
Subject: Indirect Callback with ack is called with no data
Date: Fri, 5 Jun 2009 11:49:07 +0000
Message-ID: <BAY119-W8E3C7EC7BE9C8606E2D28B0480@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bay0-omc2-s27.bay0.hotmail.com (bay0-omc2-s27.bay0.hotmail.com
	[65.54.246.163]) by alsa0.perex.cz (Postfix) with ESMTP id 63F8E246BB
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Jun 2009 13:49:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


 =


I am using indirect callback mechanism inside ack. I see that ack does not =
call my indirect callback pointer. Going through the code, I suspect that t=
he appl_ptr is not being incremented and there is no data for the indirect =
callback to be called. =


 =


After few acks, I get the indirect callback called. =


 =


With aplay, I am able to play the wav file. But with flash, there is not da=
ta being sent to the driver.

 =


Please help me with any clues.

 =


Thanks in advance.

 =


Sing

_________________________________________________________________
Insert movie times and more without leaving Hotmail=AE. =

http://windowslive.com/Tutorial/Hotmail/QuickAdd?ocid=3DTXT_TAGLM_WL_HM_Tut=
orial_QuickAdd_062009
