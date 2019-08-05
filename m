From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [Sound-open-firmware] Signed firmware availability
 for kbl/cnl
Date: Mon, 05 Aug 2019 15:36:35 +0100
Message-ID: <3aee07466dcb990ce27551224a4548a8ef37e2bb.camel@linux.intel.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <3834d741-906e-1a6b-d6cb-cccb29f98fb4@perex.cz>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jaroslav Kysela <perex@perex.cz>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Jian-Hong Pan <jian-hong@endlessm.com>, ALSA development <alsa-devel@alsa-project.org>, Daniel Drake <drake@endlessm.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2019-08-02 at 21:01 +0200, Jaroslav Kysela wrote:
> > How would we get topology or FW version from the above
> > identification ?
> 
> It was just an example. We can compose the UCM filename from any
> other
> additional information passed from the kernel. Example component
> strings for
> USB and legacy HDA:
> 
> 
>   Mixer name    : 'USB Mixer'
>   Components    : 'USB0bda:58fe'
> 
>   Mixer name    : 'Realtek ALC298'
>   Components    : 'HDA:10ec0298,17aa222e,00100103'
> 
> So we should consider what to export for SOF. Perhaps string like:
> 
>   'SOFP01234567:45670123,1:1:0-6cc8d,???TPLGVER???,3:7:0'
>   'SOFP{PCIID}:{PCISUBSYS},FW-VER,TPLG-VER,TPLG-ABI-VER'
> 
> It's just a proposal for the discussion.

Ok, we will probably need TPLG-NAME in here so that we load the correct
UCM based on TPLG NAME + HW.
> 
> By the way:
> 
>   
> https://mailman.alsa-project.org/pipermail/alsa-devel/2019-May/149409.html
> 
> The component string extensions should be also considered for other
> Intel SOC
> drivers. It seems that the long_name is misused as the UCM
> configuration
> selector for other drivers like bytcr_rt5651.c etc. The long_name for
> the
> soundcard like 'bytcht-es8316-mono-spk-in2-mic' is not really fancy.
> This
> string is used in GUI.

Sorry, do you mean it would be better to include some more encoding
into the name to make them more unique and so that UI tools and users
can better understand the UCM file features without reading the UCM
file source ?

Thanks

Liam
