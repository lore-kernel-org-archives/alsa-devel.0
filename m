Return-Path: <alsa-devel-bounces@alsa-project.org>
From: Arnd Bergmann <arnd@linaro.org>
Date: Mon, 13 Jun 2016 15:12:24 +0200
Message-ID: <3650675.mUADb08Tiz@wuerfel>
In-Reply-To: <20160613114713.GA9544@localhost.localdomain>
References: <1465686096-22156-1-git-send-email-henrik@austad.us>
 <20160613114713.GA9544@localhost.localdomain>
MIME-Version: 1.0
Subject: Re: [alsa-devel] [very-RFC 0/8] TSN driver for the kernel
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: netdev@vger.kernel.org, Henrik Austad <henrik@austad.us>, linux-kernel@vger.kernel.org, henrk@austad.us, alsa-devel@vger.kernel.org, linux-media@vger.kernel.org
List-ID: <alsa-devel@alsa-project.org>

On Monday, June 13, 2016 1:47:13 PM CEST Richard Cochran wrote:
> * Kernel Space
> 
> 1. Providing frames with a future transmit time.  For normal sockets,
>    this can be in the CMESG data.  For mmap'ed buffers, we will need a
>    new format.  (I think Arnd is working on a new layout.)
> 

After some back and forth, I think the conclusion for now was that
the timestamps in the current v3 format are sufficient until 2106
as long as we treat them as 'unsigned', so we don't need the new
format for y2038, but if we get a new format, that should definitely
use 64-bit timestamps because that is the right thing to do.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
