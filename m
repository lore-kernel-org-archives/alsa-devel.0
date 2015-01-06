From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 1/1] alsa-lib: Add snd_pcm_start_at.
Date: Tue, 06 Jan 2015 08:46:46 -0600
Message-ID: <54ABF556.6000309@linux.intel.com>
References: <1418837267-10896-1-git-send-email-timcussins@eml.cc>
 <54ABF0DF.2030805@eml.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C61E2604F0
 for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2015 15:46:48 +0100 (CET)
In-Reply-To: <54ABF0DF.2030805@eml.cc>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tim Cussins <timcussins@eml.cc>, tiwai@suse.de
Cc: nstoughton@aether.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


> I didn't make it clear that I reworked the patch so that it was
> compatible with, but not dependent on, Pierre's work (viz: Timestamping
> Evolutions). In particular you'll see that I lifted
> snd_pcm_audio_tstamp_t from his patch: This means that our patches can
> be discussed/merged independently. Was this a reasonable approach?

Fine with me. There may be another dependency though, you probably need 
to provide INFO fields and the ability to query whether the hardware 
supports this functionality (which brings us back to the discussion on 
where to store those fields..)
