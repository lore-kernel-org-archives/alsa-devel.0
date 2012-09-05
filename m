From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA: use list_move_tail instead of list_del/list_add_tail
Date: Wed, 05 Sep 2012 09:06:48 +0200
Message-ID: <5046FA08.4000300@ladisch.de>
References: <CAPgLHd_1T4S9pngzO=GXthvMD6Ke6xA3t_ZTbvLYRG+TS+2j=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPgLHd_1T4S9pngzO=GXthvMD6Ke6xA3t_ZTbvLYRG+TS+2j=w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>, tiwai@suse.de
Cc: perex@perex.cz, yongjun_wei@trendmicro.com.cn, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Wei Yongjun wrote:
> Using list_move_tail() instead of list_del() + list_add_tail().
>
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Acked-by: Clemens Ladisch <clemens@ladisch.de>
