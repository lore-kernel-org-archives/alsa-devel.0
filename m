From: jbrunet@baylibre.com
Subject: Re: [PATCH 14/15] ASoC: meson: add axg sound card DT binding
 documentation
Date: Thu, 26 Jul 2018 09:40:02 +0200
Message-ID: <9a71a5644b5257d48436a4d28972d4142a96b0eb.camel@baylibre.com>
References: <20180717153643.8806-1-jbrunet@baylibre.com>
         <20180717153643.8806-18-jbrunet@baylibre.com>
         <20180725190619.GA20234@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725190619.GA20234@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2018-07-25 at 13:06 -0600, Rob Herring wrote:
> > +- amlogic,aux-devs : List of phandles pointing to auxiliary devices
> > +- amlogic,widgets : Please refer to widgets.txt.
> > +- amlogic,routing : A list of the connections between audio components.
> 
> audio-routing IIRC

Wouldn't it make sense to do the same for widgets and aux-devs then ?

audio-widgets ?
audio-aux-devs ?
