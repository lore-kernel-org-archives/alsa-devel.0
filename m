From: Daniel Mack <zonque@gmail.com>
Subject: Re: was: Re: A reliable kernel panic (3.6.2) and
 system crash when visiting a particular website
Date: Sun, 21 Oct 2012 17:36:30 +0200
Message-ID: <CACTFLAOe-RLM6S8XNVMzfkL6F5TNx8Um5=aHWPQUoyVU_ru1Bw@mail.gmail.com>
References: <5084132B.8080609@gmail.com>
 <Pine.LNX.4.44L0.1210211126570.14867-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 18D112650F8
 for <alsa-devel@alsa-project.org>; Sun, 21 Oct 2012 17:36:30 +0200 (CEST)
Received: by mail-qc0-f179.google.com with SMTP id b14so977374qcs.38
 for <alsa-devel@alsa-project.org>; Sun, 21 Oct 2012 08:36:30 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1210211126570.14867-100000@netrider.rowland.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: security@kernel.org, alsa-devel@alsa-project.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de, pavel@ucw.cz, "Artem S. Tashkinov" <t.artem@lycos.com>, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Oct 21, 2012 5:28 PM, "Alan Stern" <stern@rowland.harvard.edu> wrote:
>
> On Sun, 21 Oct 2012, Daniel Mack wrote:
>
> > As the usb list is still in Cc: - Artem's lcpci dump shows that his
> > machine features XHCI controllers. Can anyone think of a relation to
> > this problem?
> >
> > And Artem, is there any way you boot your system on an older machine
> > that only has EHCI ports? Thinking about it, I wonder whether the freeze
> > in VBox and the crashes on native hardware have the same root cause. In
> > that case, would it be possible to share that VBox image?
>
> Don't grasp at straws.  All of the kernel logs Artem has posted show
> ehci-hcd; none of them show xhci-hcd.  Therefore the xHCI controller is
> highly unlikely to be involved.

You might be right - I'm just looking for differences between his setup and
mine that would explain why nobody else sees a severe bug that is 100%
reproducible for him.
