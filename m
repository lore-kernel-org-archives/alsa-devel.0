From: Svante Eriksson <maillists@svante.eriksson.name>
Subject: Implementing digital crossover?
Date: Mon, 20 Oct 2003 09:35:57 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <8765ikz7he.fsf@somehost>
Reply-To: Svante Eriksson <maillists@svante.eriksson.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA Developers Mailing List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi all,

What would be an appropriate ALSA way of implementing a two-way
digital crossover PCM output?  What I would like is for an ALSA PCM
device to provide two SPDIF outputs with high- and low-band audio for
the left and right channels, respectively.  I'd like for this to be
transparent to the applications that produce audio output.

Ideally, I would like for the filter parameters to be run-time
tweakable, at least initially.  Would it be possible to use a
mixer-like control interface for this?

Similar to the filter parameters, I would like to control an external
analog attenuator using an ALSA mixer control (likely through the
parallel port).

Also, would using two different SPDIF output cards be too bad even for
a proof-of-concept setup?  I'm considering adding another el-cheapo
CMI8738 based card, but don't know how much the lack of
synchronization will impact.  Has anyone got experience from this?  Or
is it possible to synchronize two cards (possibly by hw modification)?

For a real setup, what is a good PCI-based 4-ch 2xSPDIF output card
that has good ALSA support?  It should at least be capable of both
48kHz and 44.1kHz output (w/o hw resampling).  (Support for 24-bit @
96kHz would be appreciated as well.)

Does anyone know of similar projects?  The basic Google-searches
didn't yield much.

I'd appreciate any answers.

/Svante
-- 
svante at eriksson dot name


-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
