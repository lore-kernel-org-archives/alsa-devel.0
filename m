From: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>
Subject: Re: [RFC] Add DummyDevice property to UCM
Date: Thu, 26 Jun 2014 13:16:30 +0300
Message-ID: <1403777790.2606.14.camel@tkkaskin-mobl3.ger.corp.intel.com>
References: <CAGrhNMwZ=kMZuMTgaKKBERVqzfWmhpgX7pGc=zALjXN3c8_3vQ@mail.gmail.com>
 <CAGrhNMyBgm9seSrUF4vj7hmQ1MPPqaKDS73zGe0DD15jd2w86A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 280702610C1
 for <alsa-devel@alsa-project.org>; Thu, 26 Jun 2014 12:16:40 +0200 (CEST)
In-Reply-To: <CAGrhNMyBgm9seSrUF4vj7hmQ1MPPqaKDS73zGe0DD15jd2w86A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Felipe Tonello <eu@felipetonello.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

(Added Mark and Liam to CC.)

On Tue, 2014-06-24 at 12:06 -0700, Felipe Tonello wrote:
> On Mon, Jun 9, 2014 at 3:43 PM, Felipe Tonello <eu@felipetonello.com> wrote:
> > Hi,
> >
> > I would like to see what you guys think about adding a DummyDevice
> > official property to a UCM device. This is very useful for users to
> > configure properly when, let's say, the PCM is a dummy device. It is a
> > common practice on embedded systems to have dummy PCMs.
> >
> 
> ping?

Ping from me too. Felipe sent his question on my request, after we
discussed the topic on the PulseAudio mailing list. PulseAudio, and I
guess other applications too, need to handle dummy devices specially, so
it would be good to have that information in the UCM configuration file.

I'll send a patch for use-case.h.

-- 
Tanu
