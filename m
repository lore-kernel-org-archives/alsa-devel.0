From: "Yang, Brandon" <brandon.yang@intel.com>
Subject: Re: [Intel] RE: How to play second stream in linux
Date: Thu, 7 May 2009 09:53:04 +0800
Message-ID: <0C3ABB242BEE3B4C9ED1DC4723528BF0147FB1113F@pgsmsx506.gar.corp.intel.com>
References: <0C3ABB242BEE3B4C9ED1DC4723528BF001FAF7253E@pgsmsx506.gar.corp.intel.com>
	<s5hskpyyzcb.wl%tiwai@suse.de>
	<0C3ABB242BEE3B4C9ED1DC4723528BF001FAF72A92@pgsmsx506.gar.corp.intel.com>
	<s5hfxlxhqy7.wl%tiwai@suse.de>
	<0C3ABB242BEE3B4C9ED1DC4723528BF001FB031A54@pgsmsx506.gar.corp.intel.com>
	<s5h7i78q6zt.wl%tiwai@suse.de>
	<0C3ABB242BEE3B4C9ED1DC4723528BF001FB077361@pgsmsx506.gar.corp.intel.com>
	<s5h8wrmk511.wl%tiwai@suse.de>
	<0C3ABB242BEE3B4C9ED1DC4723528BF001FB0D30DE@pgsmsx506.gar.corp.intel.com>
	<s5hbpwd8i0e.wl%tiwai@suse.de>
	<0C3ABB242BEE3B4C9ED1DC4723528BF001FB10F040@pgsmsx506.gar.corp.intel.com>
	<s5hhc64w3z2.wl%tiwai@suse.de>
	<0C3ABB242BEE3B4C9ED1DC4723528BF001FB10F0EA@pgsmsx506.gar.corp.intel.com>
	<s5hbpwcw25o.wl%tiwai@suse.de>
	<0C3ABB242BEE3B4C9ED1DC4723528BF0147FA14045@pgsmsx506.gar.corp.intel.com>
	<s5hiqkh8aws.wl%tiwai@suse.de>
	<0C3ABB242BEE3B4C9ED1DC4723528BF0147FA884C3@pgsmsx506.gar.corp.intel.com>
	<s5h63gfd98h.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_0C3ABB242BEE3B4C9ED1DC4723528BF0147FB1113Fpgsmsx506garc_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 02E5D103823
	for <alsa-devel@alsa-project.org>;
	Thu,  7 May 2009 03:55:19 +0200 (CEST)
In-Reply-To: <s5h63gfd98h.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Hung,
	Allen" <Allen.Hung@intel.com>, "Lin, John Z" <john.z.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

--_002_0C3ABB242BEE3B4C9ED1DC4723528BF0147FB1113Fpgsmsx506garc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,=20

Thanks for your guidance.=20
I had added some code to play second stream in HD audio driver.=20
Our PM would like us to upstream the source code. He thinks it would be mor=
e convenient for customer if they can download the code from ALSA.
Our source code is base on kernel 2.6.24.2 and specific to ALC262.
As you know, some of our code is hard-coded for our platform. I don't know =
whether this code can meet your requirement or not.
If it can meet your requirement, please help me to upstream it. Thanks very=
 much.

The attached file is the patch file.=20

Best Regards,
Brandon

--_002_0C3ABB242BEE3B4C9ED1DC4723528BF0147FB1113Fpgsmsx506garc_
Content-Type: application/x-gzip; name="linux-2.6.24.2-hda_codec.patch.gz"
Content-Description: linux-2.6.24.2-hda_codec.patch.gz
Content-Disposition: attachment;
	filename="linux-2.6.24.2-hda_codec.patch.gz"; size=1583;
	creation-date="Wed, 06 May 2009 18:38:56 GMT";
	modification-date="Wed, 06 May 2009 18:38:56 GMT"
Content-Transfer-Encoding: base64

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

--_002_0C3ABB242BEE3B4C9ED1DC4723528BF0147FB1113Fpgsmsx506garc_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--_002_0C3ABB242BEE3B4C9ED1DC4723528BF0147FB1113Fpgsmsx506garc_--
