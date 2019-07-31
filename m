From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [Sound-open-firmware] Signed firmware availability
 for kbl/cnl
Date: Wed, 31 Jul 2019 19:52:59 +0200
Message-ID: <53dc0a03-b262-c8d3-6782-77bc12cbaf8e@perex.cz>
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
 <3f6f48ac-6eac-ba98-91ac-62c19578b1fb@linux.intel.com>
 <999df23199e5284459e66eaf351e2a2b66e25804.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <999df23199e5284459e66eaf351e2a2b66e25804.camel@linux.intel.com>
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
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Daniel Drake <drake@endlessm.com>, "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: Jian-Hong Pan <jian-hong@endlessm.com>, ALSA development <alsa-devel@alsa-project.org>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 31. 07. 19 v 16:07 Liam Girdwood napsal(a):
> On Wed, 2019-07-31 at 09:01 -0500, Pierre-Louis Bossart wrote:
>>> Any objections to using this repo for topologies too ? I know we
>>> haven't yet used it for UCMs but now is probably a good point to
>>> move
>>> (including moving the older UCMs over too).
>>
>> We'll need to figure out the license for all this, the topologies 
>> and 
>> UCM files created for SOF are all BSD 3-clause but I am not clear on 
>> older UCM files stored in alsa-lib, I don't think there was any 
>> agreement that the LGPL license applied to them.
> 
> I remember this was discussed in the past, it is possible to make all
> new UCMs and topologies BSD 3c in the new repo. We could also transfer
> over and re-license any topoloies over from alsa-lib where we had
> agreement from authors. 
> 
> This would eventually mean alsa-lib would contain "legacy" GPL
> topologies whilst alsa-ucm-conf would contain any new and BSD licences
> UCM/topologies.

I created the alsa-ucm-conf repository on github and invited you as the
maintainer:

https://github.com/alsa-project/alsa-ucm-conf

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
