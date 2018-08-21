From: Prashant Malani <pmalani@chromium.org>
Subject: Suspected heap overflow in snd_midi_event_encode_byte()
Date: Tue, 21 Aug 2018 14:24:14 -0700
Message-ID: <CACeCKacfLn8FEVU1VK8vBXM11membOOPe_4GAHeX6CAAXzD8Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f179.google.com (mail-qt0-f179.google.com
 [209.85.216.179])
 by alsa0.perex.cz (Postfix) with ESMTP id BE510267657
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2018 23:24:17 +0200 (CEST)
Received: by mail-qt0-f179.google.com with SMTP id o15-v6so16025746qtk.6
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2018 14:24:17 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

Hi,

The Chromium fuzzers detected a potential heap overflow in
snd_midi_event_encode_byte() when attempting to encode an invalid data
sequence. The potential bug was observed in alsa-lib-1.1.5 (the source
seems similar to alsa-lib-1.1.6 so it is likely present there too).

Code to reproduce (condensed to fit in an email):

std::array<int, 4> arr{ {0x0A, 0x0B, 0x0C, 0x0D} };
snd_midi_event_t* encoder;
snd_midi_event_new(arr.size(), &encoder);
for (int i = 0; i < arr.size(); i++) {
  snd_seq_event_t event;
  int result = snd_midi_event_encode_byte(encoder, arr[i], &event);
  if (result < 0) {
    // Log error and return....
  }
  if ( result == 1) {
    // Send the completed message and return.
  }
}
....

The first call to snd_midi_event_encode_byte() using byte 0x0A causes the
|encoder->qlen| to underflow and become a large unsigned value, and
|encoder->read| to become 2.  Subsequent bytes processed will get written
to the |encoder->buf| buffer, with |dev->read| getting incremented after
every byte. As a result, by the time we get to byte 0x0D, |encoder->read|
is already 4, and this results in a heap overflow (relevant line in
alsa-lib is src/seq/seq_midi_event.c:425)

I'm not sure if the above input array is a valid input to
snd_midi_event_encode_byte(), but I'm guessing we should be doing some
error checking to make sure we're not processing
incorrect/unexpected/invalid bytes.

Any suggestions about how one can submit a fix for this?

Best regards,

Prashant
