From: Dominique Larchey-Wendling <Dominique.Larchey-Wendling@loria.fr>
Subject: Strange bug in .asoundrc ??
Date: Mon, 19 Nov 2007 12:06:53 +0100
Message-ID: <47416E4D.3050207@loria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail2-relais-roc.national.inria.fr
	(mail2-relais-roc.national.inria.fr [192.134.164.83])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C19E24840
	for <Alsa-devel@alsa-project.org>; Mon, 19 Nov 2007 12:06:54 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear all,

It seems that neither the current ctl.hw function nor the following
simplified function ctl.!hw work correctly when the argument CARD is
given to the function. It works however when no argument is given as the
following test examples show it. It have alsa-lib version
1.0.14-0.4.rc3.fc7 installed on FC7.

Is this a know bug of alsa-lib ? It is strange because this bug does not
   show up with pcm.hw for example.

--- .asoundrc ------------------------

ctl.!hw {
	@args [ CARD ]
	@args.CARD {
		type string
		default "0"
	}
	type hw
	card $CARD
}

ctl.rha  "hw"
ctl.tata "hw:0"
ctl.toto "hw:1"

------------------------------------------------


rha % amixer -D rha info
Card rha 'Intel'/'HDA Intel at 0xfebfc000 irq 16'
    Mixer name    : 'SigmaTel STAC9200'
    Components    : 'HDA:83847690'
    Controls      : 6
    Simple ctrls  : 4

rha % amixer -D tata info
ALSA lib control.c:781:(snd_ctl_open_conf) Invalid type for CTL tata
definition
amixer: Control device tata open error: Invalid argument

rha % amixer -D toto info
ALSA lib control.c:781:(snd_ctl_open_conf) Invalid type for CTL toto
definition
amixer: Control device toto open error: Invalid argument
