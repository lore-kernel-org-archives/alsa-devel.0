From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [alsa-cvslog] CVS: alsa-kernel/usb usbaudio.c,1.172,1.173
Date: Thu, 09 Mar 2006 16:49:46 -0500
Message-ID: <1141940987.13319.71.camel@mindpipe>
References: <E1FHG2j-0001sX-Ln@sc8-pr-cvs1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751918AbWCIVtt@vger.kernel.org>
In-Reply-To: <E1FHG2j-0001sX-Ln@sc8-pr-cvs1.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Ladisch <cladisch@users.sourceforge.net>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-03-08 at 23:58 -0800, Clemens Ladisch wrote:
> +static const char *usb_error_string(int err)
> +{
> +	switch (err) {
> +	case -ENODEV:
> +		return "no device";
> +	case -ENOENT:
> +		return "endpoint not enabled";
> +	case -EPIPE:
> +		return "endpoint stalled";
> +	case -ENOSPC:
> +		return "not enough bandwidth";
> +	case -ESHUTDOWN:
> +		return "device disabled";
> +	case -EHOSTUNREACH:
> +		return "device suspended";
> +	case -EINVAL:
> +	case -EAGAIN:
> +	case -EFBIG:
> +	case -EMSGSIZE:
> +		return "internal error";
> +	default:
> +		return "unknown error";
> +	}
> +}

Shouldn't a generic facility be created for this?  After all these are
standard error codes and it seem like other parts of the kernel might
want to do user friendly error reporting.

Lee
