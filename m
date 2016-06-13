Return-Path: <alsa-devel-bounces@alsa-project.org>
Date: Mon, 13 Jun 2016 21:51:36 +0200
From: Richard Cochran <richardcochran@gmail.com>
Message-ID: <20160613195136.GC2441@netboy>
References: <1465686096-22156-1-git-send-email-henrik@austad.us>
 <20160613114713.GA9544@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20160613114713.GA9544@localhost.localdomain>
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
Cc: henrk@austad.us, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>, netdev@vger.kernel.org, alsa-devel@vger.kernel.org, linux-media@vger.kernel.org
List-ID: <alsa-devel@alsa-project.org>

On Mon, Jun 13, 2016 at 01:47:13PM +0200, Richard Cochran wrote:
> 3. ALSA support for tunable AD/DA clocks.  The rate of the Listener's
>    DA clock must match that of the Talker and the other Listeners.
>    Either you adjust it in HW using a VCO or similar, or you do
>    adaptive sample rate conversion in the application. (And that is
>    another reason for *not* having a shared kernel buffer.)  For the
>    Talker, either you adjust the AD clock to match the PTP time, or
>    you measure the frequency offset.

Actually, we already have support for tunable clock-like HW elements,
namely the dynamic posix clock API.  It is trivial to write a driver
for VCO or the like.  I am just not too familiar with the latest high
end audio devices.

I have seen audio PLL/multiplier chips that will take, for example, a
10 kHz input and produce your 48 kHz media clock.  With the right HW
design, you can tell your PTP Hardware Clock to produce a 10000 PPS,
and you will have a synchronized AVB endpoint.  The software is all
there already.  Somebody should tell the ALSA guys about it.

I don't know if ALSA has anything for sample rate conversion or not,
but haven't seen anything that addresses distributed synchronized
audio applications.

Thanks,
Richard
--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
