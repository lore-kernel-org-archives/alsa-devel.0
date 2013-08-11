From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] usb-audio: Fix invalid volume resolution for Logitech
 HD Webcam C525
Date: Sun, 11 Aug 2013 21:23:32 +0400
Message-ID: <5207C894.9040507@cogentembedded.com>
References: <52074DBB.7040504@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52074DBB.7040504-o+MxOtu4lMCHXe+LvDLADg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Maksim A. Boyko" <maksboyko-o+MxOtu4lMCHXe+LvDLADg@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, maksim.a.boyko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hello.

On 08/11/2013 12:39 PM, Maksim A. Boyko wrote:

> Add the volume control quirk for avoiding the kernel warning for the Logitech HD
> Webcam C525 as in the similar commit 36691e1be6ec551eef4a5225f126a281f8c051c2
> (ALSA: usb-audio: Fix invalid volume resolution for Logitech HD Webcam c310) for
> the Logitech HD Webcam C310.

> Reported-by: Maksim Boyko <maksim.a.boyko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Tested-by: Maksim Boyko <maksim.a.boyko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # 3.10.5+
> Signed-off-by: Maksim Boyko <maksim.a.boyko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

    Strange, now all the surrounding lines are indented with spaces, only the 
line you're adding looks normal.

WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
