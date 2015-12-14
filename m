From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Intel Cherry Trail -- No sound in linux
Date: Mon, 14 Dec 2015 16:54:36 -0600
Message-ID: <566F48AC.7010801@linux.intel.com>
References: <000a01d11b93$38632860$a9297920$@com>
 <56423EBB.8010108@linux.intel.com> <201511121444557079740@pcasl.com>
 <5644CA6C.5000302@linux.intel.com> <20151116154335174375283@pcasl.com>
 <564A88C9.7020008@linux.intel.com> <2015121216254115203520@pcasl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id A563426078A
 for <alsa-devel@alsa-project.org>; Mon, 14 Dec 2015 23:54:39 +0100 (CET)
In-Reply-To: <2015121216254115203520@pcasl.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ZH Tu <tuzhihe@pcasl.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 12/12/15 2:25 AM, ZH Tu wrote:
> As Pierre suggestions:
>
> try to enable a DSP loopback to see if the data isn't garbled by the driver
> amixer cset "name='pcm1_out mix 0 pcm0_in" on
>
> But we all know that the stream path is power on automaticlly, so even I do the mixer setting, the pcm1_out wighet still is in power off state.
>
> So is there way to do the loopback?

You need to do this on top of regular playback/capture settings 
otherwise yes DAPM will not power anything.
You can also try to do a loopback inside of the codec, i used this 
recently to create a mic-to-speaker loopback/larsen and show that the 
speakers were functional.

>
> Now every time I do the test:
> aplay test.wav
>
> I get the error message:
> [drm:intel_pipe_update_end [i915]] *ERROR* Atomic update failure on pipe C (start=46633 end=46634)
>
> And there're no more errors.
>
>  From the message I guess the pipe used by intel drm is blocked, so as to the pipe used by SST firmware,   that's why I cannot get data from DACDAT pin.
>
> This bug confused me for  a long time,  can anyone give some suggestions?

Apart from a bad configuration related to HDMI, this seems mostly 
unrelated to codec link issues.
