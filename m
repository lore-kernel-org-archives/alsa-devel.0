From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [Sound-open-firmware] Signed firmware availability
 for kbl/cnl
Date: Fri, 2 Aug 2019 14:24:00 -0500
Message-ID: <52e5c627-44c0-146b-2652-0e2790bac74b@linux.intel.com>
References: <CAD8Lp45Bp1xVC7NjuNaANA7kAEN2Edshw+cViaTF3tRZEumgZA@mail.gmail.com>
 <cc9fa5b52138daffb09dc5b66ea9248379c9f60e.camel@linux.intel.com>
 <CAD8Lp46GW8n8K7ttOeSje_au06BsyvCp4seVwj2wNbipei5ssA@mail.gmail.com>
 <a4b17a75-d4e0-fc6b-a286-aa6b7b281b7d@linux.intel.com>
 <CAD8Lp444soO1i8mWF73eucT16yAhy2js1byWJCTV5fn=TikHBg@mail.gmail.com>
 <9e8b667f1aa2333dbcc34b5253372d1a8667551e.camel@linux.intel.com>
 <ee34f820-0753-dfbe-09c0-7147cf229cc0@perex.cz>
 <6493f195-eb5a-1a6d-2c31-e3a4123b2ad1@linux.intel.com>
 <7c940d90-297e-19c0-2f74-1843439d5ccf@perex.cz>
 <d41b02286db2a827648d1c1ec793bbd0a55e99c1.camel@linux.intel.com>
 <8dceb60b-35a5-93e9-ce01-1eb852e93f44@perex.cz>
 <0059ed8e8f2fbd7ffbc258ca53ce5efbf1885c5b.camel@linux.intel.com>
 <1718d316-4c65-a39d-53dd-7f40f0e49e28@perex.cz>
 <1e7adedf-e12a-d409-12cf-9087cf6dbf30@linux.intel.com>
 <b7fae370-de17-f73c-c2a4-852acf6b31bc@perex.cz>
 <e59de17f39d65f0cef1249517ef1fdd374f399dd.camel@linux.intel.com>
 <3834d741-906e-1a6b-d6cb-cccb29f98fb4@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <3834d741-906e-1a6b-d6cb-cccb29f98fb4@perex.cz>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Jian-Hong Pan <jian-hong@endlessm.com>, ALSA development <alsa-devel@alsa-project.org>, sound-open-firmware@alsa-project.org, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org


>> Would we also use semantic versioning to align the UCM with the
>> topology and FW ? Currently we use semantic versioning for topology and
>> FW.
> 
> If we have the versions exported to ther user space, the UCM configuration
> loader / parser can use this information to select or verify the right UCM
> configuration. The semantic versioning in UCM files sounds good to me, too.

My understanding semantic versioning is that it provides means to handle 
minor differences where a new capability is ignored in backwards 
compatible ways. This is what we use for SOF structures between driver 
and firmware, new fields might be added but used or not depending on 
versions.

For UCM, the interaction with other layers is limited to stream numbers 
and control names, so I am not sure what semantic versioning and 
backwards compatibility would mean here? I am all for it, but I don't 
get how it would work.
