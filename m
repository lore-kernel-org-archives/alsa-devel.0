From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: conversion of opti93x driver to use cs4231-lib
Date: Sun, 20 Jan 2008 17:13:54 +0100
Message-ID: <47937342.8070100@keyaccess.nl>
References: <20080107200801.008a3cc1.krzysztof.h1@poczta.fm>
	<s5hlk707dj7.wl%tiwai@suse.de> <478385D9.1000402@keyaccess.nl>
	<47838A75.9090003@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 2ABB624858
	for <alsa-devel@alsa-project.org>; Sun, 20 Jan 2008 17:17:36 +0100 (CET)
In-Reply-To: <47838A75.9090003@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

On 08-01-08 15:36, Rene Herman wrote:

>> Missed this one originally. I'll look into this in some detail but 
>> will need a few days. Obviously, if it works, it's desirable. Maybe 
>> Jaroslav knows why it's not that way now?
> 
> Oh, and by the way, I suppose it'll be trivial but a rediff would be 
> good for testing.

Just now found time but could you provide an updated one? Mucho reject on 
cs4231_lib (which I didn't actually look at). Against some mainline tree 
(2.6.23.x or 2.6.24-rc) is preferred. The test box is not my main box and 
recompiling stuff on it is failry painful.

(I have 930, 931 and 933 to test with by the way...)

Rene.
