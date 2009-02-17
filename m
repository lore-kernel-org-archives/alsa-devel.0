From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ALSA SoC Architecture Document
Date: Tue, 17 Feb 2009 14:13:08 +0000
Message-ID: <20090217141307.GC25029@sirena.org.uk>
References: <2ee9e08d0902170411u5ff7c18fs249b5800189a57e5@mail.gmail.com>
	<20090217130701.GA25029@sirena.org.uk>
	<2ee9e08d0902170520v23a3bb7ao271ba1e9553d8c8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 36DBD1037F2
	for <alsa-devel@alsa-project.org>; Tue, 17 Feb 2009 15:13:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <2ee9e08d0902170520v23a3bb7ao271ba1e9553d8c8a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Anuj Aggarwal <anuj.aggarwal@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 17, 2009 at 06:50:32PM +0530, Anuj Aggarwal wrote:

[Please don't top post.]

> As I have mentioned earlier, I am specifically looking for some
> architecture/block diagrams and data/control paths which will enable
> users to grasp quickly what is lying underneath, instead of the user
> going and reading the kernel documentation.

What exactly are you trying to give an overview of - who is the user and
what do they want to know?

If you're trying to explain what the controls exposed to user space map
to then that's going to be specific to a given board (and codec).  If
you just want a brief overview of how things are structured in kernel
without any detail then if there's nothing in any of the presentations
then something along the lines of the quick ASCII art below *might*
help?

                 /----\
                 |ALSA|
                 \----/
                   ||
               /---------\
               |ASoC core|
               \---------/
                   ||
          =====================
          ||       ||        ||
      /-------\ /--------\ /-----\
      |Machine| |Platform| |Codec|
      \-------/ \--------/ \-----/
