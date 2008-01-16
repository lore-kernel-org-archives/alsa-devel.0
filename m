From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: ALC268 auto-parsing
Date: Wed, 16 Jan 2008 10:26:41 -0800
Message-ID: <1200508001.27806.183.camel@razman.gruemaster.com>
References: <478E4367.6040107@harddisk.is-a-geek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id BB0532450C
	for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2008 19:26:44 +0100 (CET)
In-Reply-To: <478E4367.6040107@harddisk.is-a-geek.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marco Schuster <marco@harddisk.is-a-geek.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It really depends on the OEM platform.  Some are good about putting the
correct config in bios, others not so good.  If your system is listed
specifically in one of the inf files for the windows driver, you are in
this second category (look for the pci subdevice ID or the codec
subsystem ID).

Now, the problem with the Windows INF files is that they use the Windows
GUID method for programming registers.  This is essentially a text
encryption method that makes it user unreadable.  Sigmatel is the only
vendor I know of that supplies the register settings in human readable
format, but even it has limits to what is usable to make a Linux driver.

The bios configuration is the Microsoft portion of the HDA standard.
This way, basic audio functionality works out of the box.  Most codec
vendors want to give the user better control, hence the need for
specific drivers and utilities.  We try to give the user some level of
flexibility based on what makes sense (i.e. green plug for front
speakers, etc), but it is technically feasable to have any plug support
multiple functions (using the front Mic jack as a second headphone plug
for example), so long as the codec can handle the desired configuration.

Most of the audio codec vendors for HD Audio have their codec reference
guides online.  Realtek in particular are good to work with.

Hope this is helpful.

Tobin

On Wed, 2008-01-16 at 18:48 +0100, Marco Schuster wrote:

> Hi all,
> 
> I am a bit interested in how the Realtek Windows driver gets its pin
> config. There IMO are two options:
> a) it uses the bios autoconfig - as parsing this doesn't work in alsa
> here, there must be something special in it
> b) it uses a config file - it should be easy to get out the pin config.
> 
> Any opinions what is correct way?
> 
> Marco
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis  


How much of their influence on you is a result of your influence on them?
