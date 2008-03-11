From: rct@frus.com (Bob Tracy)
Subject: Re: [alsa-devel] [regression] 2.6.25-rc4 snd-es18xx broken on Alpha
Date: Tue, 11 Mar 2008 09:07:18 -0500 (CDT)
Message-ID: <20080311140718.8B3ABDBA2@gherkin.frus.com>
References: <47D5B741.6010702@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-alpha-owner@vger.kernel.org>
In-Reply-To: <47D5B741.6010702@keyaccess.nl> "from Rene Herman at Mar 10, 2008
 11:33:37 pm"
Sender: linux-alpha-owner@vger.kernel.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Bob Tracy <rct@frus.com>, Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>, Michael Cree <mcree@orcon.net.nz>, linux-kernel@vger.kernel.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, linux-alpha@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Rene Herman wrote:
> No problems here, using either the ALSA or OSS interfaces. Have been 
> busy switching cards -- I have no hardware that can use anything other than 
> DMA 0, 1 or 3. First test is to see if it's ALSA or just the OSS emulation 
> though...

Both native ALSA and emulated OSS playback are broken based on last
night's testing.  Just to rule out sound hardware issues, this morning
I built a 2.6.25-rc4 kernel with OSS (sb driver), and that seems to be
working fine.

-- 
------------------------------------------------------------------------
Bob Tracy          |  "I was a beta tester for dirt.  They never did
rct@frus.com       |   get all the bugs out." - Steve McGrew on /.
------------------------------------------------------------------------
