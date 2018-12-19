From: Vinod Koul <vkoul@kernel.org>
Subject: Re: Loading coefficients for Audio IP
Date: Wed, 19 Dec 2018 19:29:12 +0530
Message-ID: <20181219135912.GT2472@vkoul-mobl>
References: <CAEnQRZAr22Yg=zSPJ5LEoqnkSp2dskKVXHiwwW698Ta3Bd_GTQ@mail.gmail.com>
 <s5ho99hbqk7.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <s5ho99hbqk7.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Daniel Baluta <daniel.baluta@gmail.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Cosmin Samoila <cosmin.samoila@nxp.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 19-12-18, 14:21, Takashi Iwai wrote:
> On Wed, 19 Dec 2018 09:46:37 +0100,
> Daniel Baluta wrote:
> > 
> > Hello Pierre, Liam, Mark,
> > 
> > What is the standard ALSA way of loading tables of coefficients for
> > various audio IPs?
> > 
> > We have IPs like PDM or ASRC which need large table of coefficients
> > depending on configuration. This tables can reach up to 120K in size.
> > 
> > Creating this kind of tables as arrays of integers in kernel doesn't seem
> > to be a common used solution and we will end up with large files that
> > contains only numbers.
> > 
> > Another approach that we are thinking of is to create and compile this
> > tables in userspace as raw binary files and then loading them in kernel
> > using the firmware interface.
> > 
> > Would this be an acceptable approach?
> 
> This is a topic we discuss every year in the conference ;)

Yeah and a deprecated solution exists. Daniel you *can* use TLV_BYTES
which allow you to load any size bytes into kernel using a kcontrol.

Again, it is deprecated and we are supposed to come with a cooler
solution, so you would need to move then as well

-- 
~Vinod
