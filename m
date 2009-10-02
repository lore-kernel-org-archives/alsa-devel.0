From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: OFFTOPIC atkbd.c: Use 'setkeycodes... (Was: Re: My
 Codec: IDT 92HD75B3X5 issues)
Date: Fri, 2 Oct 2009 14:41:13 +0200
Message-ID: <20091002124112.GA2553@tango.0pointer.de>
References: <598e9210910020512j67cfad99i7369bbd34228f3c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id A648A2447F
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Oct 2009 14:41:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <598e9210910020512j67cfad99i7369bbd34228f3c0@mail.gmail.com>
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

On Fri, 02.10.09 15:12, Simos Xenitellis (simos.lists@googlemail.com) wrote:

> Those keys are a 'HAL' thing. Until recently there has been a website
> by the HAL developer
> with detailed instructions. Search for 'HAL Quirk Site' on Google to
> view the site in Google cache.
> The website was not updated for some time
> (http://www.mail-archive.com/pm-utils@lists.freedesktop.org/msg01594.html)
> and being obsolete, it was probably taken down.
> Your changes would need to make it eventually to the hal-info repository,
> http://cgit.freedesktop.org/hal-info/
> Use the Freedesktop Bugzilla, product 'hal' and component 'hal-info'
> when reporting,
> https://bugs.freedesktop.org/enter_bug.cgi?product=hal

That is actually no true anymore. HAL is dead and the keycode stuff
has been moved to udev:

http://git.kernel.org/?p=linux/hotplug/udev.git;a=tree;f=extras/keymap/keymaps

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
