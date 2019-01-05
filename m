From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: RME Fireface alsa driver
Date: Sat, 5 Jan 2019 17:50:24 +0900
Message-ID: <20190105085024.GA29901@workstation>
References: <53dc5ff5-bee5-5998-dcd4-1dd1f926c857@halfshavedyaks.xyz>
 <20181211204344.GA16818@workstation>
 <a61bd3e8-0ace-3ef1-ffa4-f56c3c67fd31@halfshavedyaks.xyz>
 <alpine.DEB.2.21.1812172247580.1336@laptop>
 <c4a1e138-64b8-7926-2927-8af99134e817@halfshavedyaks.xyz>
 <20181219042203.GA8794@workstation>
 <e3b5b326-e418-eea2-fe77-a1c828d5cb09@halfshavedyaks.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F1182678D4
 for <alsa-devel@alsa-project.org>; Sat,  5 Jan 2019 09:50:32 +0100 (CET)
Received: by mail-pf1-f196.google.com with SMTP id c73so19394365pfe.13
 for <alsa-devel@alsa-project.org>; Sat, 05 Jan 2019 00:50:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <e3b5b326-e418-eea2-fe77-a1c828d5cb09@halfshavedyaks.xyz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: thet <parenthetical@halfshavedyaks.xyz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Wed, Dec 19, 2018 at 02:51:29PM +0000, thet wrote:
> I'm sorry if I inadvertently suggested something specific to me or my
> system. I did not think I was doing that.
> 
> Actually i was offering to help by testing. I'm sorry I don't have the
> skills to help in the way that would be most useful for you by compiling
> the kernel from source code - but that does not mean i am asking you to
> do something special for me. I could also help by lending my FF400 for a
> short time to a UK based developer if there is one.
> 
> I am NOT a software developer and I have very little knowledge of
> kernels or hardware level coding. I don't really have time to learn.
> 
> I shouldn't even be on this list - I only asked about the status of the
> FF400 driver here because there was no response on the alsa users list.
> 
> i will test the alsa driver for the FF400 when it becomes available in
> one of the kernels I use through the normal repos and ppas for those.
> 
> On 19/12/2018 04:22, Takashi Sakamoto wrote:
> > I'm sorry but I have no interest in your system at all, thus I don't use
> > my time for something of it. I'm a software developer, not your servant.

Today fixes are queued to stable kernels; v4.20[1], v4.19[2], v4.14[3].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=980bbac3dc0c038f080d2420b00615b9995c977b
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=3f6f84af6cb95d81e005a5f19868487710173de8
[3] https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/commit/?id=199205774df4fe196065c5a6bb016158d673ea1f

Regards

Takashi Sakamoto
