From: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [very-RFC 0/8] TSN driver for the kernel
Date: Tue, 14 Jun 2016 19:04:44 +0200
Message-ID: <20160614170442.GA1825__26482.8617372133$1465971286$gmane$org@netboy>
References: <1465686096-22156-1-git-send-email-henrik@austad.us>
 <20160613114713.GA9544@localhost.localdomain>
 <20160613195136.GC2441@netboy>
 <20160614121844.54a125a5@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20160614121844.54a125a5@lxorguk.ukuu.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: netdev@vger.kernel.org, Henrik Austad <henrik@austad.us>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>, henrk@austad.us, alsa-devel@vger.kernel.org, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 14, 2016 at 12:18:44PM +0100, One Thousand Gnomes wrote:
> On Mon, 13 Jun 2016 21:51:36 +0200
> Richard Cochran <richardcochran@gmail.com> wrote:
> > 
> > Actually, we already have support for tunable clock-like HW elements,
> > namely the dynamic posix clock API.  It is trivial to write a driver
> > for VCO or the like.  I am just not too familiar with the latest high
> > end audio devices.
> 
> Why high end ? Even the most basic USB audio is frame based and
> isosynchronous to the USB clock. It also reports back the delay
> properties.

Well, I guess I should have said, I am not too familiar with the
breadth of current audio hardware, high end or low end.  Of course I
would like to see even consumer devices work with AVB, but it is up to
the ALSA people to make that happen.  So far, nothing has been done,
afaict.

Thanks,
Richard

--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
