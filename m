From: Alexey Fisher <bug-track@fisher-privat.net>
Subject: ControlNames: Input Source/ Capture Source/ Jack Mode?
Date: Sun, 06 Dec 2009 12:26:52 +0100
Message-ID: <1260098812.3767.34.camel@zwerg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id E789D24400
	for <alsa-devel@alsa-project.org>; Sun,  6 Dec 2009 12:26:53 +0100 (CET)
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

Hallo,
i have question about controlnames, or if i correctly understand it:

Capture Source - you can capture only from one of two (or more) sources.
On switching mic a or mic b will be enabled or disabled.
             /--(o)--mic b
cap switch---
             \--(x)--mic a

Input Source - same as capture source but more verbose
                           /---(Mute/Vol)--Mic a
input switch--(a(x)/b(o))--
                           \---(Mute/Vol)--Mic b

more complicated setup:

                            +---(Mute/Vol)--Mic a
input switch a-(a(x)/b(o))--+
                            +---(Mute/Vol)--Mic b
input switch b-(a(x)/b(o))--+


jack mode - you can choice to put VREF on the line or not.
                           /---(Mute/Vol)-(mode)-Mic a
input switch--(a(x)/b(o))--
                           \---(Mute/Vol)-(mode)-Mic b

i hope i understand it correctly.
Now is my situation:

                                   +---------+--(Mute/Rec)-(mode)-Mic a
input switch a-(a(x)/b(o)/mix(o))--+         |
                                   +---------+--(Mute/Rec)-(mode)-Mic b
input switch b-(a(x)/b(o)/mix(o))--+         |
                                   +--mixer--+<---(Mute/Vol for Mic a/b)


are there any way to make alsamixer less verbose but still productive?
