From: Pavel Machek <pavel@ucw.cz>
Subject: Re: patch to make suspend/resume work
Date: Tue, 20 Apr 2004 15:50:11 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <20040420135011.GA1413@openzaurus.ucw.cz>
References: <20040418055415.8FE2077A2B@mail.lmc.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-S264010AbUDVTu1@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20040418055415.8FE2077A2B@mail.lmc.cs.sunysb.edu>
To: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org, alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi!

> It seems that pci config space is messed up after resume for Intel
> ICH4 audio controller (on Dell Latitude D600, but I notice that others
> also complain about this problem). Consequently resume from S3 causes
> oops with snd_intel8x0 module. If the module is removed before suspend
> and loaded afterwards, I still get oops. The following simple patch
> fixes the problem. With this, I can leave alsa untouched during
> suspend/resume.
> 


Looks good to me. Probably more drivers need this...
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         
