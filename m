From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: help for a levelmeter
Date: Thu, 17 Oct 2002 22:48:54 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DAF2236.EA2A74BD@libero.it>
References: <20021015224039.59921.qmail@web12207.mail.yahoo.com>
		<3DADC922.5000808@club-internet.fr> <3DAE626C.7601185C@libero.it> <87r8ep9ca1.fsf@sulphur.joq.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jack O'Quin <joq@io.com>
Cc: Laurent Georget <lgeorget2@club-internet.fr>, karsten wiese <annabellesgarden@yahoo.de>, Devel Alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jack O'Quin wrote:
> 
> Abramo Bagnara <abramo.bagnara@libero.it> writes:
> 
> > The correct plugin has already been written and available inside
> > alsa-lib.
> >
> > The name is pcm_meter, it's lockless and perfectly integrated with ALSA
> > PCM chains.
> >
> > A sample implementation for curses level meter is already available and
> > working.
> >
> > It's very simple to add other *-meters, scopes, etc.
> 
> That's great!
> 
> Is there any user-level documentation for all this cool stuff?

Ehm... guess what...

No, wait: I wrote some lines in asoundrc.txt:

  type meter            # Meter PCM
  slave STR             # Slave name (see pcm_slave)
  # or
  slave {               # Slave definition or name
    pcm STR             # Slave PCM name
    # or
    pcm { }             # Slave PCM definition
  }
  [frequency INT]       # Updates per second
  scopes {              # Scopes
    ID STR              # Scope name (see pcm_scope)
  # or
    ID { }              # Scope definition (see pcm_scope)
  }

# PCM scope type definition
pcm_scope_type.NAME {
  [lib STR]             # Library file (default libasound.so)
  [open STR]            # Open function (default
_snd_pcm_scope_NAME_open)
}

# PCM scope definition
pcm_scope.NAME {
  type STR              # Scope type
  ...
}

The rest is obvious, of course ;-)))

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
