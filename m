From: Daniel Wagner <wagi@monom.org>
Subject: Re: [alsa-devel] ALSA regression Macbook Air 5, 2: No sound from
 the loudspeaker
Date: Tue, 26 Mar 2013 13:35:47 +0100
Message-ID: <51519623.9040603@monom.org>
References: <51509B84.2050106@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51509B84.2050106@monom.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 03/25/2013 07:46 PM, Daniel Wagner wrote:
> I experience a regression on my Macbook Air 2012 model with the 3.9-rc
> kernels (v3.9-rc2-284-gaea8b5d) The symptoms are that there is just no
> sound from the loudspeakers. The headphone output works fine.

Oh, there is already a fix in the mainline tree.

   ALSA: hda - Fix missing EAPD/GPIO setup for Cirrus codecs


Haven't tested it yet but looks like then one I was looking for.

cheers,
daniel
