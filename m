From: Orm Finnendahl <finnendahl@folkwang-hochschule.de>
Subject: hdsp.c code
Date: Tue, 3 Sep 2002 10:56:21 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020903085621.GA2801@finnendahl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

In the current cvs checkpout of hdsp.c code there seem to be some
leftovers starting line 2874:

<...>
                } else {
                       hdsp->type = Digiface;
<<<<<<< hdsp.c
                        hdsp->card_name = "RME Hammerfall DSP (Digiface)";
                                          hdsp->ss_channels = DIGIFACE_SS_CHANNELS;
                                                              hdsp->ds_channels = DIGIFACE_DS_CHANNELS;
=======
>>>>>>> 1.10
                } 

                  hdsp_write (hdsp, HDSP_jtagReg, HDSP_S_PROGRAM);
<...>


I just got rid of the offending lines and hope that's o.k.

--
Orm


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
