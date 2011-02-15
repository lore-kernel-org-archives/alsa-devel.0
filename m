From: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: [PATCH v19 0/3] TI Wl1273 FM radio driver.
Date: Tue, 15 Feb 2011 17:59:52 -0200
Message-ID: <4D5ADB38.4070600@redhat.com>
References: <1297757626-3281-1-git-send-email-matti.j.aaltonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <1297757626-3281-1-git-send-email-matti.j.aaltonen@nokia.com>
Sender: linux-media-owner@vger.kernel.org
To: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, hverkuil@xs4all.nl, sameo@linux.intel.com, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Em 15-02-2011 06:13, Matti J. Aaltonen escreveu:
> Hello.
> 
> Now I've refactored the code so that the I2C I/O functions are in the 
> MFD core. Also now the codec can be compiled without compiling the V4L2
> driver.
> 
> I haven't implemented the audio routing (yet), but I've added a TODO
> comment about it in the codec file.

Matti,

It looks ok on my eyes. As most of the changes is at the V4L part, it is
probably better to merge this patch via my tree.

Cheers,
Mauro
