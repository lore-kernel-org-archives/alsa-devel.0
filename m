From: Lee Revell <rlrevell@joe-job.com>
Subject: Rawmidi device naming
Date: Fri, 22 Sep 2006 13:38:42 -0400
Message-ID: <1158946723.1097.90.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I use the following code in my driver to initialize 2 MPU-like ports:

/* Dreamchip MIDI initializer */
static int __devinit snd_dream_midi_init(struct snd_card_dream *dream, struct snd_card_dream_midi *midi, int device, char *name)
{
        snd_rawmidi_t *rmidi;
        int err; 

        if ((err = snd_rawmidi_new(dream->card, name, device, 1, 1, &rmidi)) < 0) 
                return err; 
        midi->dream = dream;
        strcpy(rmidi->name, name);
        snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_OUTPUT, &snd_dream_midi_output);
        snd_rawmidi_set_ops(rmidi, SNDRV_RAWMIDI_STREAM_INPUT, &snd_dream_midi_input);
        rmidi->info_flags |= SNDRV_RAWMIDI_INFO_OUTPUT |
                             SNDRV_RAWMIDI_INFO_INPUT |
                             SNDRV_RAWMIDI_INFO_DUPLEX;
        rmidi->private_data = midi;
        midi->rmidi = rmidi;
        return 0;
}

/* Dreamchip MIDI constructor */
int __devinit snd_dream_midi(struct snd_card_dream *dream)
{       
        struct snd_card_dream_midi *midi1 = &dream->midi1;
        struct snd_card_dream_midi *midi2 = &dream->midi2;
        int err;
                
        if ((err = snd_dream_midi_init(dream, midi1, 0, "Dreamchip MPU interface 1")) < 0)
                return err;
        midi1->port = MPU1_DATA;
                
        if ((err = snd_dream_midi_init(dream, midi2, 1, "Dreamchip MPU interface 2")) < 0)
                return err;
        midi2->port = MPU2_DATA;

        return 0;
}

But the client names are wrong!

~ # aplaymidi -l
 Port    Client name                      Port name
 62:0    Midi Through                     Midi Through Port-0
 64:0    Dreamchip MPU interface 1        Dreamchip MPU interface 1
 64:32   Dreamchip MPU interface 1        Dreamchip MPU interface 2
 88:0    Virtual Raw MIDI 3-0             VirMIDI 3-0
 89:0    Virtual Raw MIDI 3-1             VirMIDI 3-1
 90:0    Virtual Raw MIDI 3-2             VirMIDI 3-2
 91:0    Virtual Raw MIDI 3-3             VirMIDI 3-3

Why do both ports get "Dreamchip MPU interface 1" for the client name? 

Lee



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
