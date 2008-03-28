From: "Alexandre BOUIN" <a.bouin@kerlink.fr>
Subject: ALSA Lib : snd_dlopen lib error
Date: Fri, 28 Mar 2008 17:46:33 +0100
Message-ID: <9463.20486623353$1206722896@news.gmane.org>
References: <47ED0038.9020808@acdstar.com>
	<20080328150256.GA16855@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from scanner-relay-corvus2.pulsation.fr
	(scanner-relay-corvus2.pulsation.fr [80.74.64.70])
	by alsa0.perex.cz (Postfix) with SMTP id 9D18024768
	for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2008 17:46:59 +0100 (CET)
In-Reply-To: 
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
To: 'ALSA-devel' <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi list,

I'm currently to develop an application that use ALSA Lib mixer features. My
first ALSA user application.
I've succeed in compiling it but on application start, the message is
printed : 
KPV test prepare DAC ... snd_mixer_open
ALSA lib control.c:878:(snd_ctl_open_conf) symbol _snd_ctl_hw_open is not
define
d inside (null)
problems problems attaching alsa mixer: No such device or address
Function failed with error code -1

My linking parameters are : 
-lasound -lm -rdynamic -ldl
Cross compiling for arm in Cygwin

I got this version on both embedded and compiler : libdl-2.3.2.so 

All tips would be greatfull ;)

Regards,
Alex.
