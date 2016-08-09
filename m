From: "focus.luo" <focus.luo@linux.intel.com>
Subject: Re: [PATCH 1/2] alsabat: automation test scripts
Date: Tue, 09 Aug 2016 17:24:59 +0800
Message-ID: <57A9A16B.6050807@linux.intel.com>
References: <1470625225-1237-1-git-send-email-focus.luo@linux.intel.com>	<1470625225-1237-2-git-send-email-focus.luo@linux.intel.com>	<s5hshuemn7k.wl-tiwai@suse.de>	<1470728868.31650.4.camel@loki>
 <s5hk2fqmkv3.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id ABB312657B1
 for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2016 10:57:40 +0200 (CEST)
In-Reply-To: <s5hk2fqmkv3.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@intel.com>
Cc: Focus Luo <focus.luo@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 2016=E5=B9=B408=E6=9C=8809=E6=97=A5 16:01, Takashi Iwai wrote:
> On Tue, 09 Aug 2016 09:47:48 +0200,
> Liam Girdwood wrote:
>> On Tue, 2016-08-09 at 09:10 +0200, Takashi Iwai wrote:
>>> On Mon, 08 Aug 2016 05:00:24 +0200,
>>> focus.luo@linux.intel.com wrote:
>>>> From: Focus Luo <focus.luo@intel.com>
>>>>
>>>> This patch includes automated test scripts for linux audio driver
>>>> based on alsa-lib interface by using alsabat as test tool.
>>>> It supports analog and display(HDMI/DP) audio test.
>>>> The package needs the alsa-utils, alsa-lib installed environment.
>>>>
>>>> Signed-off-by: Focus Luo <focus.luo@intel.com>
>>> You need to modify Makefile.am, too.  Otherwise these contents won't
>>> be included in the release.
>>>
>> Where would be a good place to install the scripts ? I think the
>> intention from Focus is that these are local scripts for use by devs and
>> not really for everyone. They could perhaps go in
>> ${prefix}/share/alsa/abat/tests ?
> Well, if this is merely an example, we don't have to install it, but
> just keep it in tarball, too.
In future, we will continue to add/update some scripts in the the folder =

of "/alsa-utils/bat/tests" for alsabat. So would it be better to keep it =

as folder but not tarball?
>
> Takashi
>
