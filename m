From: Metyl Methylius <the.metyl@gmail.com>
Subject: alsa virtual sound card (with networked output)
Date: Tue, 11 Jan 2011 15:51:20 +0100
Message-ID: <AANLkTinXD8u9riu9uwhJPsdKthUHDmK5K1o_+7vv4mcU@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 05234243CA
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 15:51:22 +0100 (CET)
Received: by ewy19 with SMTP id 19so8596796ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 06:51:20 -0800 (PST)
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

Hello everyone,

I was wondering if its possible to just create a "virtual" sound card
using alsa which will just sent its audio stream to other computer
(using TCP/IP or UDP for example). On the other end there would be
some kind of server (or just nc -u -l -p 31337 | aplay ). I want to do
it on alsa layer because other aps using alsa will get immediate
support.

It should be something like described in

http://alsa.opensrc.org/index.php/Network

but with transparent support for all alsa based applications. I dont
care about syncronization or transmission delay. Any pointers as how
this could be done in alsa ?

metyl

--
This mess was sent using 100% recycled electrons. If you want to get
rid of this mess just turn off your computer,
