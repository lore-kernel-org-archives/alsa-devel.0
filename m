From: Tim Cussins <timcussins@eml.cc>
Subject: Re: [PATCH v2 1/1] alsa-lib: Add snd_pcm_start_at.
Date: Fri, 09 Jan 2015 10:12:14 +0000
Message-ID: <54AFA97E.3040407@eml.cc>
References: <1418837267-10896-1-git-send-email-timcussins@eml.cc>
 <54ABF0DF.2030805@eml.cc> <54ABF556.6000309@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 8BD3026147D
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 11:12:18 +0100 (CET)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 0F82820977
 for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2015 05:12:18 -0500 (EST)
In-Reply-To: <54ABF556.6000309@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de
Cc: nstoughton@aether.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 06/01/15 14:46, Pierre-Louis Bossart wrote:
>
>> I didn't make it clear that I reworked the patch so that it was
>> compatible with, but not dependent on, Pierre's work (viz: Timestamping
>> Evolutions). In particular you'll see that I lifted
>> snd_pcm_audio_tstamp_t from his patch: This means that our patches can
>> be discussed/merged independently. Was this a reasonable approach?
>
> Fine with me. There may be another dependency though, you probably need
> to provide INFO fields and the ability to query whether the hardware
> supports this functionality (which brings us back to the discussion on
> where to store those fields..)
>

Fair point :) But the patch, as it stands, doesn't depend on those fields.
