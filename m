From: Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [PATCH] ASoC: sgtl5000: add avc enable control
Date: Tue, 30 May 2017 13:46:26 +0200
Message-ID: <ef96e444-e5e4-fe5d-0176-fd551b85c3e6@skidata.com>
References: <1496142019-13533-1-git-send-email-richard.leitner@skidata.com>
 <20170530113347.xtb3u4dpt6rnu6tl@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170530113347.xtb3u4dpt6rnu6tl@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, dev@g0hl1n.net
List-Id: alsa-devel@alsa-project.org

On 05/30/2017 01:33 PM, Mark Brown wrote:
> On Tue, May 30, 2017 at 01:00:19PM +0200, Richard Leitner wrote:
> 
>> +
>> +	SOC_SINGLE("AVC Enable", SGTL5000_DAP_AVC_CTRL, 0, 1, 0),
> 
> All on/off switches should end in Switch as covered in ControlNames.txt.

Ok. Sorry & Thanks. I'll send a V2.
