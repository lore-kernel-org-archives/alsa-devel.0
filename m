From: Daniel Baluta <daniel.baluta@gmail.com>
Subject: Loading coefficients for Audio IP
Date: Wed, 19 Dec 2018 10:46:37 +0200
Message-ID: <CAEnQRZAr22Yg=zSPJ5LEoqnkSp2dskKVXHiwwW698Ta3Bd_GTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: sound-open-firmware@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Cosmin Samoila <cosmin.samoila@nxp.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, "S.j. Wang" <shengjiu.wang@nxp.com>
List-Id: alsa-devel@alsa-project.org

Hello Pierre, Liam, Mark,

What is the standard ALSA way of loading tables of coefficients for
various audio IPs?

We have IPs like PDM or ASRC which need large table of coefficients
depending on configuration. This tables can reach up to 120K in size.

Creating this kind of tables as arrays of integers in kernel doesn't seem
to be a common used solution and we will end up with large files that
contains only numbers.

Another approach that we are thinking of is to create and compile this
tables in userspace as raw binary files and then loading them in kernel
using the firmware interface.

Would this be an acceptable approach?

thanks,
Daniel.
