From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [asoc:for-5.2 101/107]
 sound/soc/sprd/sprd-pcm-compress.c:110 sprd_platform_compr_drain_notify()
 warn: variable dereferenced before check 'cstream' (see line 105)
Date: Wed, 3 Apr 2019 09:46:19 +0300
Message-ID: <20190403064619.GI32613@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kbuild-bounces@lists.01.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.01.org/mailman/options/kbuild>,
 <mailto:kbuild-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/kbuild/>
List-Post: <mailto:kbuild@lists.01.org>
List-Help: <mailto:kbuild-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/kbuild>,
 <mailto:kbuild-request@lists.01.org?subject=subscribe>
Errors-To: kbuild-bounces@lists.01.org
Sender: "kbuild" <kbuild-bounces@lists.01.org>
To: kbuild@01.org, Baolin Wang <baolin.wang@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2
head:   6d5e2bf9d203e4d9e08ca2e9420c6ff22ad190af
commit: cce1396936ef2b347d622b4d49718818eb32029d [101/107] ASoC: sprd: Add Spreadtrum audio compress offload support

smatch warnings:
sound/soc/sprd/sprd-pcm-compress.c:110 sprd_platform_compr_drain_notify() warn: variable dereferenced before check 'cstream' (see line 105)

# https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git/commit/?id=cce1396936ef2b347d622b4d49718818eb32029d
git remote add asoc https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
git remote update asoc
git checkout cce1396936ef2b347d622b4d49718818eb32029d
vim +/cstream +110 sound/soc/sprd/sprd-pcm-compress.c

cce13969 Baolin Wang 2019-03-27   98  
cce13969 Baolin Wang 2019-03-27   99  static int sprd_platform_compr_trigger(struct snd_compr_stream *cstream,
cce13969 Baolin Wang 2019-03-27  100  				       int cmd);
cce13969 Baolin Wang 2019-03-27  101  
cce13969 Baolin Wang 2019-03-27  102  static void sprd_platform_compr_drain_notify(void *arg)
cce13969 Baolin Wang 2019-03-27  103  {
cce13969 Baolin Wang 2019-03-27  104  	struct snd_compr_stream *cstream = arg;
cce13969 Baolin Wang 2019-03-27 @105  	struct snd_compr_runtime *runtime = cstream->runtime;
                                                                            ^^^^^^^^^^^^^^^^

cce13969 Baolin Wang 2019-03-27  106  	struct sprd_compr_stream *stream = runtime->private_data;
cce13969 Baolin Wang 2019-03-27  107  
cce13969 Baolin Wang 2019-03-27  108  	memset(stream->info_area, 0, sizeof(struct sprd_compr_playinfo));
cce13969 Baolin Wang 2019-03-27  109  
cce13969 Baolin Wang 2019-03-27 @110  	if (cstream)
                                            ^^^^^^^

cce13969 Baolin Wang 2019-03-27  111  		snd_compr_drain_notify(cstream);
cce13969 Baolin Wang 2019-03-27  112  }
cce13969 Baolin Wang 2019-03-27  113  
